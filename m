Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUFGWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUFGWpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUFGWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:45:30 -0400
Received: from gate.firmix.at ([80.109.18.208]:24551 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S265106AbUFGWpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:45:25 -0400
Subject: Re: Flushing the swap
From: Bernd Petrovitsch <bernd@firmix.at>
To: Hal Nine <hal9@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406072234.SAA07853@grex.cyberspace.org>
References: <200406072234.SAA07853@grex.cyberspace.org>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1086648023.8894.17.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 00:40:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 00:34, Hal Nine wrote:
> Is there any way of making linux flush out all pages out of swap
> space?  I want to have 0K of used swap space.

swapoff -a

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


