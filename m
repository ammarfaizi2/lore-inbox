Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUCHX4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUCHX4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:56:39 -0500
Received: from smtp01.web.de ([217.72.192.180]:64794 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261411AbUCHX4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:56:38 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Date: Tue, 9 Mar 2004 00:56:32 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200403090014.03282.thomas.schlichter@web.de> <jeptbmlxb2.fsf@sykes.suse.de>
In-Reply-To: <jeptbmlxb2.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403090056.36223.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. März 2004 00:43 schrieb Andreas Schwab:
> Thomas Schlichter <thomas.schlichter@web.de> writes:
> > P.S.: Wouldn't it be nice if gcc complained about these mistakes?
>
> Among these 18 cases are 13 false positives. :-)

Yes, but at least it's a very bad coding style, and a warning may be useful to 
find the _real_ bugs...

  Thomas

