Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290739AbSBSQUC>; Tue, 19 Feb 2002 11:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSBSQTx>; Tue, 19 Feb 2002 11:19:53 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:56793 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S291463AbSBSQTf>; Tue, 19 Feb 2002 11:19:35 -0500
Date: Tue, 19 Feb 2002 10:19:23 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200202191619.KAA72194@tomcat.admin.navo.hpc.mil>
To: roy@karlsbakk.net, "Jens Schmidt" <j.schmidt@paradise.net.nz>,
        linux-kernel@vger.kernel.org, j.schmidt@paradise.net.nz
Subject: Re: secure erasure of files?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> >I would strongly encourage somebody with fluent Norsk/English skills
> >to do a translation and post it to the list.
> 
> I'll do my very best ...
> 
> (translated by Roy Sigurd Karlsbakk - please don't spam me in case of bad
> speling :)
> 
> With permission from the leader of Research and Deveopment department, I
> quote his complete answer:
> 
> I'll try to answer your questions:
> 
> The short answer is: No. It is not possible to read data that are (really)
> physically overwritten.

[snip]

In the non-destructive read case - true.

HOWEVER: forensic specialists can:

	http://www.cs.auckland.ac.nz/~pgut001/secure_del.html
or (same paper)
	http://www.usenix.org/publications/library/proceedings/sec96/full_papers/gutmann/

> 
> Addition:
> 
> Still, it should be said that this is being argued upon between the
> 'wise' ones. This is - there are people that mean it is possible
> to read/recover overwritten data. But we have, as mentioned above,
> not found any scientific documentation or decriptions of how this
> can be done.

See the paper referenced above. There may be more recent documents, but
this one is quite clear on the limitations of erasure using the standard
drive electronics.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
