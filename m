Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWFGU4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWFGU4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 16:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWFGU4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 16:56:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:5431 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932407AbWFGU4n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 16:56:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=NSHCC2PtMA3NvAQEJrKD/QQixqOHFaKE/Z1ew9DJrChOLwr/LGPTZ01EzxrYJtr4/OFVBiY3O6GGFtchIOE2VbpUo9eniuDgYC8DgAijIdGDNTDS8O8L5Dfr1Yk54SE1wBcrwDy265z5RuFfcCWMy5efkq1A9Al/cgjfvOlkpVg=
Date: Wed, 7 Jun 2006 22:55:51 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Updated sysctl documentation take #2
Message-Id: <20060607225551.9b7e9688.diegocg@gmail.com>
In-Reply-To: <20060607124641.516c7fff@localhost.localdomain>
References: <20060607205316.bbb3c379.diegocg@gmail.com>
	<20060607124641.516c7fff@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 7 Jun 2006 12:46:41 -0700,
Stephen Hemminger <shemminger@osdl.org> escribió:

> The network stuff was all in Documentation/networking/ip-sysctl.txt.
> Someone else has already started fixing it.

Darn, didn't know that. Anyway, I merged that file into
Documentation/sysctl/ because IMO all sysctls must be in the same
place.
