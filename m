Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSGLTOR>; Fri, 12 Jul 2002 15:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSGLTOQ>; Fri, 12 Jul 2002 15:14:16 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:24195 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316774AbSGLTOO>; Fri, 12 Jul 2002 15:14:14 -0400
Date: Fri, 12 Jul 2002 21:35:11 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Anton Altaparmakov <aia21@cantab.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@transmeta.com>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <5.1.0.14.2.20020712194731.044115f0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0207122130230.3808-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Anton Altaparmakov wrote:

> But Linus is wanting exactly that! As far as I understand, Linus would like 
> a generic interface sitting at the higher layers, and that is used by the 
> ide/atapi/scsi layers. I read this as implying that the user space 
> interface will also be only one. It will talk to the higher layers, the 
> lower layers can then do all the hw specific magic.

Oh bother! Where does one get the secret Linus decoder ring?

-- 
function.linuxpower.ca

