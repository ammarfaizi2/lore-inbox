Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUA0Kkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 05:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbUA0Kkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 05:40:36 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:20734 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263452AbUA0Kke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 05:40:34 -0500
From: johann lombardi <johann.lombardi@bull.net>
Reply-To: johann.lombardi@bull.net
Organization: BULL S.A.
To: Robert van Herk <rherk@students.cs.uu.nl>, linux-kernel@vger.kernel.org
Subject: Re: PS/2 Mouse problems with kernel 2.6.2_rc2
Date: Tue, 27 Jan 2004 11:39:17 +0100
User-Agent: KMail/1.5.4
References: <40163820.9070105@students.cs.uu.nl>
In-Reply-To: <40163820.9070105@students.cs.uu.nl>
MIME-Version: 1.0
Message-Id: <200401271139.17761.johann.lombardi@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/01/2004 11:42:52,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/01/2004 11:46:02,
	Serialize complete at 27/01/2004 11:46:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone have any clues? For example: am I doing wrong or is it a
> kernel bug ;-)?
Are you using DMA with your disk?
For my part, "hdparm -d1 /dev/xxx" solves the problem.

Johann

