Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbTCZOF1>; Wed, 26 Mar 2003 09:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbTCZOF1>; Wed, 26 Mar 2003 09:05:27 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:40964 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id <S261696AbTCZOF1>;
	Wed, 26 Mar 2003 09:05:27 -0500
Message-ID: <3E81B63B.8080608@kn.vutbr.cz>
Date: Wed, 26 Mar 2003 15:16:27 +0100
From: Michal Schmidt <schmidt@kn.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Andrew Ebling <aebling@tao-group.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reproducible terrible interactivity since 2.5.64bk2
References: <3E81945C.4010102@kn.vutbr.cz> <1048687681.6345.13.camel@spinel.tao.co.uk>
In-Reply-To: <1048687681.6345.13.camel@spinel.tao.co.uk>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Ebling wrote:
> 
> 
> I'm seeing similar on 2.5.66; xmms pauses when doing disk intensive
> tasks.
> 

This may be a different problem. My test is not very disk intensive. It 
is more CPU intensive (bzip2 compression). The disk is only slightly 
used when running my testing script.

Michal Schmidt.

