Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965443AbWFTDjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965443AbWFTDjF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965455AbWFTDjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:39:05 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:1451 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965443AbWFTDjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:39:03 -0400
Date: Tue, 20 Jun 2006 12:39:44 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: Preben Traerup <Preben.Trarup@ericsson.com>
Cc: ebiederm@xmission.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before
 crashing
Message-Id: <20060620123944.3fb2b5a4.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <4496A677.3020301@ericsson.com>
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
	<m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
	<20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com>
	<m1y7vtia7r.fsf@ebiederm.dsl.xmission.com>
	<4496A677.3020301@ericsson.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 15:28:23 +0200
Preben Traerup <Preben.Trarup@ericsson.com> wrote:

> Strictly speaking for myself: Nothing.
> 
> Mr. Akiyama Nobuyuk gave an example from his environment which is cluster systems.
> I was the one saying we in our Telco systems could use this feature too.
> 
> The only thing Mr. Akiyama Nobuyuk and I have in common is we both would like to do
> something before crash dumping, simply because the less mess we will have to cleanup
> afterwards in the system taking over, the better.
> 
> Mr. Akiyama Nobuyuk operates on SCSI devices to avoid filesystem corruptions.
> My usage would be more like notifying external management to get traffic 
> redirected to server systems taking over.
> 

Thanks, Preben.
I appreciate your good interpretation;-)

Thanks,
--
Akiyama, Nobuyuki

