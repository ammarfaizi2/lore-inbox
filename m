Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbULFRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbULFRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbULFRcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:32:36 -0500
Received: from hermes.domdv.de ([193.102.202.1]:6929 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261582AbULFRbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:31:42 -0500
Message-ID: <41B49773.1010006@domdv.de>
Date: Mon, 06 Dec 2004 18:31:31 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: host name length
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org> <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr> <41B48C9E.6030607@osdl.org>
In-Reply-To: <41B48C9E.6030607@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Hi Jan,
> Can you be more specific, please?  about (which) DNS FAQ.
> I found several "DNS FAQ"s, but nothing specific about
> DNS hostname lengths.
> 

63 characters per label (=hostname) as to:

[RFC1035] Mockapetris, P., "Domain Names - Implementation and 
Specifications", STD 13, RFC 1035, November 1987.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
