Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWIFS4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWIFS4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWIFS4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:56:43 -0400
Received: from vzn1-20146.ce.pixelgate.net ([66.254.95.226]:58762 "EHLO
	spinics.net") by vger.kernel.org with ESMTP id S1750909AbWIFS4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:56:43 -0400
From: ellis@spinics.net
Message-Id: <200609061856.k86IuS61017253@no.spam>
Subject: Re: bogofilter ate 3/5
To: w@1wt.eu (Willy Tarreau)
Date: Wed, 6 Sep 2006 11:56:28 -0700 (PDT)
Cc: ellis@spinics.net (Rick Ellis), linux-kernel@vger.kernel.org
In-Reply-To: <20060906180020.GD604@1wt.eu> from "Willy Tarreau" at Sep 06, 2006 08:00:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, but doing something could simply consist in adding a header
> that anyone is free to filter on or not.

The problem with that is the post gets no indication that his
mail has been filtered. The way it works now is the rejection
happens at SMTP time and that causes the poster to see the
problem. If people filtered on a header, you'd never know why you
weren't getting a response.

--
http://www.spinics.net/lists/kernel/

