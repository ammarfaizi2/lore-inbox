Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTDNU5k (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTDNU5k (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:57:40 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:963 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263787AbTDNU5i (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:57:38 -0400
Date: Mon, 14 Apr 2003 22:08:59 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030414210856.GA10688@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <20030414210006.GA7831@suse.de> <92940000.1050353740@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92940000.1050353740@flay>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 01:55:40PM -0700, Martin J. Bligh wrote:

 > True - however I should have included some more info ... Andrew worked
 > out that some of the hottest ones lead to a null ptr dereference
 > immediately afterwards anyways, so they're actually pointless.

Erk, that doesn't sound good. Example ?

		Dave

