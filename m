Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUD0DOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUD0DOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUD0DOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:14:24 -0400
Received: from canalmusic.webnext.com ([213.161.194.17]:16901 "HELO
	www.canalmusic.com") by vger.kernel.org with SMTP id S263702AbUD0DOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:14:22 -0400
Message-ID: <408DCFE9.3040407@canalmusic.com>
Date: Tue, 27 Apr 2004 05:13:45 +0200
From: Gilles May <gilles@canalmusic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <408DC0E0.7090500@gmx.net>
In-Reply-To: <408DC0E0.7090500@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

>The attached patch blacklists all modules having "Linuxant" or "Conexant"
>in their author string. This may seem a bit broad, but AFAIK both
>companies never have released anything under the GPL and have a strong
>history of binary-only modules.
>  
>
Blacklisting modules?!

Oh come on!
I agree the '\0' trick is not really nice, but blacklisting modules is 
not really better. It's not a functionality that adds anything to the 
kernel.
If ppl want/have to use that module let them!

Take care, Gilles

-- 
If you don't live for something you'll die for nothing!



