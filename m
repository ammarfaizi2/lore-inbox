Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275521AbTHNUpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275524AbTHNUpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:45:47 -0400
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:8065 "EHLO topaz")
	by vger.kernel.org with ESMTP id S275521AbTHNUpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:45:46 -0400
To: Samuel Flory <sflory@rackable.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 boot hang
References: <Pine.LNX.4.44.0308141428330.3360-100000@localhost.localdomain>
	<87znicjegu.fsf@mcs.anl.gov> <3F3BE3E8.7060606@rackable.com>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 14 Aug 2003 15:44:36 -0500
In-Reply-To: <3F3BE3E8.7060606@rackable.com> (Samuel Flory's message of
 "Thu, 14 Aug 2003 12:32:56 -0700")
Message-ID: <87r83oj7ez.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sam" == Samuel Flory <sflory@rackable.com> writes:

  Sam>   Try compiling it with ACPI support on;-)

this also didn't work. The only think that is slightly weird about
this machine is a large 3-4 number of scsi controllers. Can you think
of anything else that might be worth trying?
thanks..
 -nld
