Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTJRVZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJRVZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 17:25:27 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:64784 "EHLO
	cygnus-ext.enyo.de") by vger.kernel.org with ESMTP id S261850AbTJRVZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 17:25:26 -0400
Date: Sat, 18 Oct 2003 23:25:23 +0200
To: Michael Still <mikal@stillhq.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Resent 2.6 patch] Correct case sensitivity in make mandocs
Message-ID: <20031018212523.GA28033@deneb.enyo.de>
References: <1065496497.3f822fb14994b@dubai.stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065496497.3f822fb14994b@dubai.stillhq.com>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Still wrote:

> The attached patch corrects case sensitivity in the mandocs make
> target. XML is case insensitive, and a bunch of the kernel-doc assumes
> this.

ITYM "the kernel docs SGML application", and not "XML".  XML *is* case
sensitive.
