Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287743AbSAITTC>; Wed, 9 Jan 2002 14:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSAITSw>; Wed, 9 Jan 2002 14:18:52 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:36034 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287743AbSAITSk>; Wed, 9 Jan 2002 14:18:40 -0500
Date: Wed, 9 Jan 2002 20:18:31 +0100
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Subject: kdev_t changes cause NVdriver compile failure?
Message-ID: <20020109191831.GA8760@neon.hh59.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have upgraded from 2.4.18pre1 to 2.5.2-pre10.
Now my NVdriver doesn't compile anymore. I know, you don't want to deal with
third-party object drivers.

My knowledge is poor, but by investigating through nv.c from
NVIDIA_kernel-1.0-2313 and linux kernel headers I found relations to kdev_t
and I also have seen that there have been changes in latest kernel
pre-patches.

Might this be related?

Thank you very much, I'm missing X very much:)

Axel Siebenwirth
