Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTF2Th7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTF2Thc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:37:32 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:41824 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264088AbTF2TgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:36:14 -0400
Date: Sun, 29 Jun 2003 15:48:06 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <3EFF4177.6000705@post.pl>
To: "Leonard Milcin Jr." <thervoy@post.pl>, linux-kernel@vger.kernel.org
Message-id: <200306291548060930.02159FEE@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl>
 <3EFF4177.6000705@post.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********


>Ok, I forgot about enterprise users with lots of data, and probably
>lacking free space, so I missed a point.
>

Yeppers.  Also that the eventual goal (at least in  my mind) is to allow
this to be done on a running r/w filesystem safely, which isn't as tough
a problem as it sounds.

>--
>"Unix IS user friendly... It's just selective about who its friends are."
>                                                        -- Tollef Fog Heen
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



