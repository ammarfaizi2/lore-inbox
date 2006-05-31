Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWEaVXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWEaVXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWEaVXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:23:14 -0400
Received: from dvhart.com ([64.146.134.43]:6802 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965093AbWEaVXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:23:13 -0400
Message-ID: <447E093B.7020107@mbligh.org>
Date: Wed, 31 May 2006 14:23:07 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@google.com>, linux-kernel@vger.kernel.org,
       apw@shadowen.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
In-Reply-To: <20060531140652.054e2e45.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Bligh <mbligh@google.com> wrote:
> 
>>The x86_65 panic in LTP has changed a bit. Looks more useful now.
>>Possibly just unrelated new stuff. Possibly we got lucky.
> 
> What are you doing to make this happen?

runalltests on LTP

M.
