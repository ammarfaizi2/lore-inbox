Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTESWdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTESWdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:33:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10502 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263182AbTESWdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:33:31 -0400
Message-ID: <3EC95EA9.9060504@zytor.com>
Date: Mon, 19 May 2003 15:46:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <1053289316.10127.41.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519105152.GD8978@holomorphy.com> <babheo$s9r$1@cesium.transmeta.com> <20030519224414.GG8978@holomorphy.com>
In-Reply-To: <20030519224414.GG8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Mon, May 19, 2003 at 02:14:00PM -0700, H. Peter Anvin wrote:
> 
>>This "cure" sucks worse than the disease.  Now you're putting it onto
>>everyone who maintains userspace to do the same repetitive task of
>>"sanitizing" this.  Especially for things this trivial, this is a
>>ridiculous concept.
>>For 2.7, getting real exportable ABI headers is so bloody necessary
>>it's not even funny.  However, for 2.5, breaking things randomly is
>>not the way to go.
> 
> I would rather have real exportable ABI headers, yes. We don't have
> them and AFAIK sanitized copies are the current policy.
> 

Unfortunately "the current policy" is unrealistic, and repeating it
doesn't make it any less so.

	-hpa

