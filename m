Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266537AbUAWHuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUAWHuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:50:24 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:39079 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266537AbUAWHuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:50:19 -0500
Date: Fri, 23 Jan 2004 07:48:57 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: DMI updates from 2.4
Message-ID: <20040123074856.GH9327@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <E1Ajuub-0000x4-00@hardwired> <20040122233734.3ffe096b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122233734.3ffe096b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 11:37:34PM -0800, Andrew Morton wrote:
 > davej@redhat.com wrote:
 > >
 > > +static __init int apm_is_horked_d850md(struct dmi_blacklist *d)
 > 
 > this new function is unreferenced.

ok, I'll chase that one down later.

		Dave

