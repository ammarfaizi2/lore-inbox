Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVAGEFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVAGEFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 23:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVAGEFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 23:05:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53651 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261194AbVAGEF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 23:05:27 -0500
Message-ID: <41DE0A81.2010509@pobox.com>
Date: Thu, 06 Jan 2005 23:05:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <hermes@gibson.dropbear.id.au>
CC: Andrew Morton <akpm@osdl.org>, Pavel Roskin <proski@gnu.org>,
       orinoco-deve@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Another trivial orinoco update
References: <20041103034433.GB5441@zax>
In-Reply-To: <20041103034433.GB5441@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Jeff/Andrew please apply:
> 
> This patch alters the convention with which orinoco_lock() is invoked
> in the orinoco driver.  This should cause no behavioural change, but
> reduces meaningless diffs between the mainline and CVS version of the
> driver.  Another small step towards a merge.
> 
> Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

applied


