Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUG2Rgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUG2Rgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUG2RdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:33:02 -0400
Received: from holomorphy.com ([207.189.100.168]:36757 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267505AbUG2RcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:32:09 -0400
Date: Thu, 29 Jul 2004 10:32:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Avi Kivity <avi@exanet.com>
Cc: jmoyer@redhat.com, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
Message-ID: <20040729173201.GV2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Avi Kivity <avi@exanet.com>, jmoyer@redhat.com, suparna@in.ibm.com,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	linux-osdl@osdl.org
References: <20040702130030.GA4256@in.ibm.com> <20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com> <41091FAA.6080409@exanet.com> <20040729171037.GS2334@holomorphy.com> <410932C2.6080102@exanet.com> <20040729172659.GU2334@holomorphy.com> <41093421.3080601@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41093421.3080601@exanet.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 08:30:09PM +0300, Avi Kivity wrote:
> Yes. Sorry for being so terse. But busy-waiting isn't acceptable for 
> anything more than a demonstration, or (extermely) special-purpose 
> servers, like maybe embedded stuff.

Agreed. One of the points of my demonstration was to emphasize how dire
the state of affairs is.


-- wli
