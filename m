Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUHJP2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUHJP2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUHJP2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:28:11 -0400
Received: from demon.dataflame.co.uk ([216.127.70.18]:22211 "EHLO
	demon.dataflame.co.uk") by vger.kernel.org with ESMTP
	id S267469AbUHJP1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:27:02 -0400
Message-ID: <4118E822.3000303@future-ericsoft.com>
Date: Tue, 10 Aug 2004 11:22:10 -0400
From: Eric Masson <cool_kid@future-ericsoft.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com>
In-Reply-To: <20040809161003.554a5de1.pj@sgi.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointer! My user mode program is running. Any idea how to 
control which console it shows up on?

Eric

Paul Jackson wrote:

>Try grep'ing for call_usermodehelper()
>
>  
>

