Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTJJKxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTJJKxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:53:13 -0400
Received: from holomorphy.com ([66.224.33.161]:18048 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262050AbTJJKxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:53:10 -0400
Date: Fri, 10 Oct 2003 03:55:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: YoshiyaETO <eto@soft.fujitsu.com>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       linux-kernel@vger.kernel.org,
       Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be
Subject: Re: 2.7 thoughts
Message-ID: <20031010105514.GB727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	YoshiyaETO <eto@soft.fujitsu.com>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	linux-kernel@vger.kernel.org,
	Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
	Fabian.Frederick@prov-liege.be
References: <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010063039.GA700@holomorphy.com> <047b01c38f00$60b34840$6a647c0a@eto> <20031010074030.GB700@holomorphy.com> <04d501c38f0b$2864c210$6a647c0a@eto> <20031010090942.GC700@holomorphy.com> <053f01c38f18$f6212420$6a647c0a@eto> <20031010105021.GA727@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010105021.GA727@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 07:26:26PM +0900, YoshiyaETO wrote:
>>     Could tell me what is the real issue you think?

On Fri, Oct 10, 2003 at 03:50:21AM -0700, William Lee Irwin III wrote:
> Using reserved areas for kernel metadata marked as ZONE_HIGHMEM creates

Ergh, s/HIGHMEM/NORMAL/ here.


-- wli
