Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933956AbWKWVpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933956AbWKWVpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934093AbWKWVpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:45:10 -0500
Received: from main.gmane.org ([80.91.229.2]:14478 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S933956AbWKWVpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:45:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: Entropy Pool Contents
Date: Thu, 23 Nov 2006 22:43:48 +0100
Message-ID: <ek54nf$icj$3@sea.gmane.org>
References: <ek2nva$vgk$1@sea.gmane.org> <45660CDA.6090806@garzik.org>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e179249004.adsl.alicedsl.de
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Grab an entropy generator like egd or audio-entropyd, etc.

I thought about running rngd, but will this be of any help if writing
into /dev/*random does not change the entropy from zero on this machine?

Greetings,

  Gunter

