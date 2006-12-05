Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968619AbWLEStZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968619AbWLEStZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968623AbWLEStZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:49:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:50030 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968619AbWLEStY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:49:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=sH4hKLvf+SN8Pign++XTye7PqEpwdjHxrbCXq5umqu5JHReBGwA0Da/7upWbrer1xuMBIOLO0AUdqkR4ooX1BdoNBU1PE+rUi1G1B5+O0xXRwfatL+mBHd2B8xQENdlawUu2rp8oHxmJ9BG8mHbCZUUS/v3mIuOc7xKVXu8si7Y=
Date: Tue, 5 Dec 2006 21:49:21 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
Message-ID: <20061205184921.GA5029@martell.zuzino.mipt.ru>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 12:22:29AM -0500, Kristian Høgsberg wrote:
> I'm announcing an alternative firewire stack that I've been working on
> the last few weeks.

Is mainline firewire so hopeless, that you've decided to rewrite it?
Could you show some ugly places in it?

We can end up with two not quite working sets of firewire drivers your
way.

