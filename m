Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTHSTXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbTHSTWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:22:34 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:36049
	"EHLO bastard") by vger.kernel.org with ESMTP id S261305AbTHSTTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:19:41 -0400
Message-ID: <3F427838.60600@tupshin.com>
Date: Tue, 19 Aug 2003 12:19:20 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030813 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
References: <3F4268C1.9040608@redhat.com> <3F427122.9040408@redhat.com>
In-Reply-To: <3F427122.9040408@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Ulrich Drepper wrote:
>
>  
>
>>Go into a directory mounted via NFS.  You need write access.  Then
>>execute this little program:
>>    
>>
>
>Just to be clear: the client is running 2.6.  The server in my case runs
>a 2.4 kernel.
>
Duplicated here. Same symptoms with a 2.6.0-test3 server. Works with 2.4 
client, breaks with 2.6 client.

-Tupshin

