Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSKVLwe>; Fri, 22 Nov 2002 06:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSKVLwe>; Fri, 22 Nov 2002 06:52:34 -0500
Received: from holomorphy.com ([66.224.33.161]:37765 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264666AbSKVLwd>;
	Fri, 22 Nov 2002 06:52:33 -0500
Date: Fri, 22 Nov 2002 03:56:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [RFC] hangcheck-timer module
Message-ID: <20021122115646.GU11776@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Wim Coekaerts <Wim.Coekaerts@oracle.com>
References: <20021121201931.GH770@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121201931.GH770@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 12:19:31PM -0800, Joel Becker wrote:
> it then uses the TSC (warning: portability needed)

ISTR get_cycles() being around, which should be defined for other arches.


Bill
