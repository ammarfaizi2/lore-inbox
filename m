Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTEZKR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 06:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTEZKR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 06:17:29 -0400
Received: from sirius.ure.cas.cz ([147.231.2.2]:29924 "EHLO sirius.ure.cas.cz")
	by vger.kernel.org with ESMTP id S264332AbTEZKR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 06:17:28 -0400
From: Daniel Sobe <daniel.sobe@epost.de>
Reply-To: daniel.sobe@epost.de
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: Swapoff w/regular file causes Oops
Date: Mon, 26 May 2003 06:30:39 -0400
User-Agent: KMail/1.5
References: <20030525175806.8879.qmail@web9606.mail.yahoo.com>
In-Reply-To: <20030525175806.8879.qmail@web9606.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305260630.39443.daniel.sobe@epost.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> program first, though. Hopefully, my machine isn't the only
> one doing this.

Well, I had this problem when using RH8, but using kernel 2.4.20-8 from RH9. 
Switching completely to RH9 solved this (and I'm using 2.4.20-9 now which 
works, too). I'm using a 1GB swap file on an ext3 partition.

Daniel

