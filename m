Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbTFLLKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbTFLLKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:10:36 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:36872 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264819AbTFLLKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:10:35 -0400
Date: Thu, 12 Jun 2003 12:24:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
Message-ID: <20030612122419.A27158@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <20030612111437.GE28900@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030612111437.GE28900@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Thu, Jun 12, 2003 at 02:14:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 02:14:37PM +0300, Matti Aarnio wrote:
> I have been debugging long and hard a thing where IO is done
> with O_DIRECT flag applied to open(2).
> 
> Unlike Linux, FreeBSD (where this flag originates, apparently)

O_DIRECT comes from IRIX.

