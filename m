Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264916AbSIRCKD>; Tue, 17 Sep 2002 22:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264918AbSIRCKD>; Tue, 17 Sep 2002 22:10:03 -0400
Received: from mnh-1-02.mv.com ([207.22.10.34]:11527 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264916AbSIRCKC>;
	Tue, 17 Sep 2002 22:10:02 -0400
Message-Id: <200209180318.WAA05100@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: David Coulson <david@davidcoulson.net>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: user-mode port 0.59-2.4.19-5 
In-Reply-To: Your message of "Tue, 17 Sep 2002 16:31:25 +0100."
             <3D874ACD.3000309@davidcoulson.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Sep 2002 22:18:43 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david@davidcoulson.net said:
> I don't seem to have this in 2.4.19-4. Is there a kernel configuration
>  option I'm supported to enable? I had a quick look, but I couldn't
> find  anything and 'oldconfig' hasn't thrown anything interesting up
> recently  which I might have missed.

You need to have booted UML with an mconsole notify socket specified on
the command line.

				Jeff

