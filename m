Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVHKDTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVHKDTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 23:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVHKDTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 23:19:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:1443 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932215AbVHKDTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 23:19:08 -0400
Message-ID: <42FAC3A5.3010000@pobox.com>
Date: Wed, 10 Aug 2005 23:19:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: domen@coderock.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>
Subject: Re: [patch 14/16] net/tms380tr: replace direct assignment with set_current_state()
References: <20050808222936.090422000@homer> <20050808223054.376836000@homer>
In-Reply-To: <20050808223054.376836000@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
> From: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> 
> 
> Use set_current_state() instead of direct assignment of
> current->state.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> Signed-off-by: Domen Puncer <domen@coderock.org>

why?


