Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWJXMvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWJXMvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWJXMvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:51:52 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:43019 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161049AbWJXMvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:51:52 -0400
Date: Tue, 24 Oct 2006 14:51:44 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] KVM: userspace interface
Message-ID: <20061024125144.GK4943@rhun.haifa.ibm.com>
References: <453CC390.9080508@qumranet.com> <20061023132946.49E62250143@cleopatra.q>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023132946.49E62250143@cleopatra.q>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 01:29:46PM -0000, Avi Kivity wrote:


> +		struct {
> +		} debug;

ISTR some versions of gcc had problems with empty structs.

Cheers,
Muli


