Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUHXU5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUHXU5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUHXU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:57:54 -0400
Received: from holomorphy.com ([207.189.100.168]:13190 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268306AbUHXU5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:57:47 -0400
Date: Tue, 24 Aug 2004 13:57:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040824205745.GV2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org> <20040824205621.GU2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824205621.GU2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 01:56:21PM -0700, William Lee Irwin III wrote:
> __builtin_return_address() with non-constant arguments is unsupported on
> various architectures.

Sorry, nonzero arguments.


-- wli
