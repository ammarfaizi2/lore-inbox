Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTESWvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTESWvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:51:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34056 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263315AbTESWvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:51:42 -0400
Message-ID: <3EC962E1.90801@zytor.com>
Date: Mon, 19 May 2003 16:04:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <1053289316.10127.41.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519105152.GD8978@holomorphy.com> <babheo$s9r$1@cesium.transmeta.com> <20030519224414.GG8978@holomorphy.com> <3EC95EA9.9060504@zytor.com> <20030519225602.GH8978@holomorphy.com>
In-Reply-To: <20030519225602.GH8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Mon, May 19, 2003 at 03:46:01PM -0700, H. Peter Anvin wrote:
> 
>>Unfortunately "the current policy" is unrealistic, and repeating it
>>doesn't make it any less so.
> 
> No contest there; unfortunately unrealistic amounts of work seem to
> be required to get around the general state of affairs at times. =(
> Does it really have to be 2.7? It seems most of this would be header
> reorganization with no runtime impact on the kernel.
> 

It is; it doesn't have to be in 2.7 if someone would be willing to step
up and do it in time for 2.6.  Personally I wouldn't have a prayer; I'm
already way to deep into too many projects...

	-=hpa


