Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbUKQM4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbUKQM4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUKQM4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:56:35 -0500
Received: from holomorphy.com ([207.189.100.168]:45767 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262301AbUKQM4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:56:34 -0500
Date: Wed, 17 Nov 2004 04:56:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1
Message-ID: <20041117125624.GR3217@holomorphy.com>
References: <20041116014213.2128aca9.akpm@osdl.org> <20041117113225.GP3217@holomorphy.com> <20041117123401.GQ3217@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117123401.GQ3217@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 03:32:25AM -0800, William Lee Irwin III wrote:
>> Dies at boot on sparc64 repeatedly printk'ing some PROMLIB message.
>> Hunting for the offending patch...

On Wed, Nov 17, 2004 at 04:34:01AM -0800, William Lee Irwin III wrote:
> Also present in virgin 2.6.10-rc2. Now applying benh's sunzilog.c fix
> and seeing if it helps.

It does not appear to have helped. So bk snapshot searching it is. =(


-- wli
