Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbUDQMui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 08:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbUDQMuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 08:50:37 -0400
Received: from holomorphy.com ([207.189.100.168]:6283 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263926AbUDQMud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 08:50:33 -0400
Date: Sat, 17 Apr 2004 05:50:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Kill off hugepage_vma()
Message-ID: <20040417125014.GE743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'David Gibson' <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <20040416062215.GF26707@zax> <200404162214.i3GMEdF22343@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404162214.i3GMEdF22343@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 03:14:39PM -0700, Chen, Kenneth W wrote:
> Minor FYI: on ia64, huge page address is in region 4.

This is an artifact of the implementation, not a hardware limitation.


-- wli
