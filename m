Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbTG3KKD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269509AbTG3KKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:10:03 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:11169 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S269321AbTG3KKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:10:00 -0400
Message-ID: <3F2799B3.3020109@basmevissen.nl>
Date: Wed, 30 Jul 2003 12:10:59 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: module-init-tools don't support gzipped modules.
References: <20030730062245.382c5dad.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20030730062245.382c5dad.vmlinuz386@yahoo.com.ar>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerardo Exequiel Pozzi wrote:

> 
> The possibility of compressing the modules is interesting, like for
> example in cases of construction of small systems or initrd.
> 

In both cases, you might use a compressed file system. Maybe you better 
try to save memory and disk space by compressing less critical stuff 
than kernel modules.

Regards,

Bas.



