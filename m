Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130333AbRCBFm5>; Fri, 2 Mar 2001 00:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130336AbRCBFmr>; Fri, 2 Mar 2001 00:42:47 -0500
Received: from sp28fe.nerdc.ufl.edu ([128.227.128.108]:54740 "EHLO
	smtp.ufl.edu") by vger.kernel.org with ESMTP id <S130333AbRCBFme>;
	Fri, 2 Mar 2001 00:42:34 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2ac8 lost char devices
Message-ID: <983511748.3a9f32c4e5ca2@webmail.ufl.edu>
Date: Fri, 02 Mar 2001 00:42:28 -0500
From: <rml@ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually, its not just ps/2 mice -- it seems to be something generic to char
devices. agpgartis failing to register itself, too.

what changed with char device handling from ac7 to ac8?

robert love
rml@ufl.edu
