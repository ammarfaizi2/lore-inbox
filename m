Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTLSK20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTLSK20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 05:28:26 -0500
Received: from holomorphy.com ([199.26.172.102]:40342 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262327AbTLSK2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 05:28:25 -0500
Date: Fri, 19 Dec 2003 02:28:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alexander Poquet <atp@csbd.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
Message-ID: <20031219102821.GJ31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alexander Poquet <atp@csbd.org>, linux-kernel@vger.kernel.org
References: <20031219101806.9CD491E030CA3@csbd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219101806.9CD491E030CA3@csbd.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003 02:16:27 -0800, William Lee Irwin III wrote:
>> Okay, nothing matching other bugreports turned up here. I might have
>> to ask you to try to capture some log information. Do you have a null
>> modem cable or a null modem adapter and serial cable, and another box
>> to hook that up to?

On Fri, Dec 19, 2003 at 10:27:12AM +0000, Alexander Poquet wrote:
> Unfortunately not.  Is there any other way I might capture some output?  I 
> was thinking I might be able to install a null loop a la while( 1 ) { } 
> somewhere before filesystems are mounted, and then move it down until 
> the blank out occurs.  What do you think?  Could you point me to a relevant
> place in the boot process that I could do this?  Would it even help?

The hardware solution is better, but I'll settle for anything you can
get that way.


-- wli
