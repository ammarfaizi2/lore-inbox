Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbREKBSa>; Thu, 10 May 2001 21:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbREKBSV>; Thu, 10 May 2001 21:18:21 -0400
Received: from lsd.nurk.org ([63.172.78.98]:1152 "HELO lsd.nurk.org")
	by vger.kernel.org with SMTP id <S132557AbREKBSM>;
	Thu, 10 May 2001 21:18:12 -0400
Date: Thu, 10 May 2001 18:18:11 -0700 (PDT)
From: Sean Swallow <sean@swallow.org>
To: <linux-kernel@vger.kernel.org>
Subject: Riva console frame buffer
Message-ID: <Pine.LNX.4.33.0105101813220.1140-100000@lsd.nurk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

Hi... I'm trying to use the riva console frame buffer driver under x86
linux. It works, but not the way I want it to, and I'm having a hard time
finding info about kernel args for the riva frame buffer.

Right now when I bootup it's in 640x480, and I change it to 1024x768 @70Hz
w/ fbset in /etc/rc.local . I would like to give the kernel an arg to
startup in 1024x768; eg video=riva:mode:1024x768-70,ypan,vc:1-8

Is there a way to do this w/ the riva frame buffer? Is there a list of
kernel args for the riva frame buffer?

my hardware:

VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)
mag DX700T

kernel 2.4.3ac14 and 2.4.4ac3

thank you,

-- 
Sean J. Swallow
pgp (6.5.2) keyfile @ https://nurk.org/keyfile.txt







