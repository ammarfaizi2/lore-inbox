Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUAQT5l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUAQT5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:57:41 -0500
Received: from codepoet.org ([166.70.99.138]:39084 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S266143AbUAQT5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:57:39 -0500
Date: Sat, 17 Jan 2004 12:57:41 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Nuno Monteiro <nuno@itsari.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4] Remove ide bootup noise
Message-ID: <20040117195741.GA5260@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Nuno Monteiro <nuno@itsari.org>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org
References: <20040117194707.GC19667@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117194707.GC19667@hobbes.itsari.int>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jan 17, 2004 at 07:47:07PM +0000, Nuno Monteiro wrote:
> Hi Marcelo,
> 
> 
> Recently, while syncing my local tree from 2.4.22 to 2.4.25-pre I found 
> this little patchlet (back from the 2.4.20 days, AFAIR) that still 
> applies and looks pertinent. I believe the original author is Erik 
> Andersen, although I can't say for certain since I don't have the 
> original email around anymore. Also, I seem to recall that Jens Axboe 

Yup, that was me.  I later submitted a follow-on patch that
implemented proper hpa detection, which was accepted into
2.6.x, but never made it into 2.4,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
