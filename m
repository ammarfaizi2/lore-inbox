Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWEXUZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWEXUZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWEXUZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:25:09 -0400
Received: from nevyn.them.org ([66.93.172.17]:36247 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932326AbWEXUZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:25:07 -0400
Date: Wed, 24 May 2006 16:25:06 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Program to convert core file to executable.
Message-ID: <20060524202506.GA6326@nevyn.them.org>
Mail-Followup-To: vamsi krishna <vamsi.krishnak@gmail.com>,
	linux-kernel@vger.kernel.org
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com> <20060524173821.GA1292@nevyn.them.org> <3faf05680605241306t64f63225i4d25af3e92a9d9f9@mail.gmail.com> <20060524200837.GA5679@nevyn.them.org> <3faf05680605241319y3b0f332v45922fc34ea0bf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3faf05680605241319y3b0f332v45922fc34ea0bf8@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 01:49:32AM +0530, vamsi krishna wrote:
> Hello Dan,
> 
> 
> >You might want to take a look at GDB's generate-core-file command.
> >
> 
> Does gdb take care (loading) of core files generated on machine which
> support ASLR (Address  Space Layout Randomization)? , currently ASLR
> is being shipped as exec-shield in redhat

Why would it matter?

-- 
Daniel Jacobowitz
CodeSourcery
