Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTKTVzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTKTVzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:55:40 -0500
Received: from holomorphy.com ([199.26.172.102]:58544 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262878AbTKTVzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:55:39 -0500
Date: Thu, 20 Nov 2003 13:55:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, Voicu Liviu <pacman@mscc.huji.ac.il>,
       kerin@recruit2recruit.net
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120215536.GM22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Voicu Liviu <pacman@mscc.huji.ac.il>,
	kerin@recruit2recruit.net
References: <20031120025730.GD22764@holomorphy.com> <3FBC917E.7090506@mscc.huji.ac.il> <20031120101830.GH22764@holomorphy.com> <3FBC9604.1020007@mscc.huji.ac.il> <20031120103117.GI22764@holomorphy.com> <3FBC996F.2060902@mscc.huji.ac.il> <20031120104220.GJ22764@holomorphy.com> <3FBC9C94.4030603@mscc.huji.ac.il> <20031120172059.GA22495@64m.dyndns.org> <20031120213810.GA5094@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120213810.GA5094@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 November 2003, at 12:20:59 -0500, Christopher Li wrote:
>> Have your try Petr Vandrovec's patch?
>> ftp://platan.vc.cvut.cz/pub/vmware

On Thu, Nov 20, 2003 at 10:38:10PM +0100, Jose Luis Domingo Lopez wrote:
> I just tried to "recompile" VMware Workstation 4.0.1 build 5289 applying:
> ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-update45.tar.gz
> And the preblem persists. I get a BUG in the logs, very similar to the
> one I reported yesterday (both with 2.6.0-test9-mm4):

Okay, several questions:
(a) is _this_ run with 2.6.0-test9-mm4?
(b) which _exact_ fixes did you run with?


-- wli
