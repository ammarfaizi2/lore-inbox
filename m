Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272927AbTG3PZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272932AbTG3PZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:25:19 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:20411
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272927AbTG3PYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:24:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test2-mm1 results
Date: Thu, 31 Jul 2003 01:28:49 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]> <170360000.1059513518@flay> <17830000.1059577281@[10.10.2.4]>
In-Reply-To: <17830000.1059577281@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307310128.50189.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 01:01, Martin J. Bligh wrote:
> OK, so test2-mm1 fixes the panic I was seeing in test1-mm1.
> Only noticeable thing is that -mm tree is consistently a little slower
> at kernbench

Could conceivably be my hacks throwing the cc cpu hogs onto the expired array 
more frequently.

Con

