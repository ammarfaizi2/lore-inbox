Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVD2Gsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVD2Gsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVD2Gsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:48:31 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:60334 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262429AbVD2GsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:48:24 -0400
X-ORBL: [67.124.119.21]
Date: Thu, 28 Apr 2005 23:48:19 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gilles Pokam <gpokam@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory
Message-ID: <20050429064819.GA15501@taniwha.stupidest.org>
References: <ba83582205042816522e2a7a93@mail.gmail.com> <20050429030313.GA10344@taniwha.stupidest.org> <ba8358220504282233754de43b@mail.gmail.com> <20050429054351.GA12654@taniwha.stupidest.org> <ba8358220504282248344d5e78@mail.gmail.com> <20050429061254.GB12654@taniwha.stupidest.org> <ba83582205042823452a3446f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba83582205042823452a3446f6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 11:45:40PM -0700, Gilles Pokam wrote:

> the simplest way to say is: I want the pagefault handler to return a
> memory page when it encounters a pagefault exceptions due to an
> invalid address or incorrect page protection.

where should this page come from?
