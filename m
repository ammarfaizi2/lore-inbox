Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSLJGmA>; Tue, 10 Dec 2002 01:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSLJGl7>; Tue, 10 Dec 2002 01:41:59 -0500
Received: from holomorphy.com ([66.224.33.161]:23451 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266721AbSLJGl6>;
	Tue, 10 Dec 2002 01:41:58 -0500
Date: Mon, 9 Dec 2002 22:49:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: 2.5.50-mjb2 (scalability / NUMA patchset)
Message-ID: <20021210064910.GF9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@holomorphy.com>
References: <19270000.1038270642@flay> <134580000.1039414279@titus> <32230000.1039502522@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32230000.1039502522@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 10:42:03PM -0800, Martin J. Bligh wrote:
> Speed up page init on boot (Bill Irwin)

Hang on until I push the fixes for this guy out (probably tonight).


On Mon, Dec 09, 2002 at 10:42:03PM -0800, Martin J. Bligh wrote:
> devclass_panic					Bill Irwin
> 	Reorder sysfs init for topo to avoid panic

That really needs to go straight to Linus and fast, I'll push.



Thanks,
Bill
