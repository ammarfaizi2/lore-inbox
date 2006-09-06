Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWIFUNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWIFUNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWIFUNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:13:39 -0400
Received: from 1wt.eu ([62.212.114.60]:13074 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751548AbWIFUNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:13:38 -0400
Date: Wed, 6 Sep 2006 22:13:33 +0200
From: Willy Tarreau <w@1wt.eu>
To: ellis@spinics.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
Message-ID: <20060906201333.GA711@1wt.eu>
References: <20060906180020.GD604@1wt.eu> <200609061856.k86IuS61017253@no.spam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609061856.k86IuS61017253@no.spam>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 11:56:28AM -0700, ellis@spinics.net wrote:
> > OK, but doing something could simply consist in adding a header
> > that anyone is free to filter on or not.
> 
> The problem with that is the post gets no indication that his
> mail has been filtered. The way it works now is the rejection
> happens at SMTP time and that causes the poster to see the
> problem. If people filtered on a header, you'd never know why you
> weren't getting a response.

Valid point.

Regards,
Willy

