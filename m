Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272216AbTG3Au6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 20:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272416AbTG3Au6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 20:50:58 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:24755
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272216AbTG3Au5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 20:50:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O11int for interactivity
Date: Wed, 30 Jul 2003 10:55:23 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org>
In-Reply-To: <200307301038.49869.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301055.23950.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 10:38, Con Kolivas wrote:
> Update to the interactivity patches. Not a massive improvement but
> more smoothing of the corners.

Woops my bad. Seems putting things even at the start of the expired array can 
induce a corner case. Will post an O11.1 in a few mins to back out that part.

Con

