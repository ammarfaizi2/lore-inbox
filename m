Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966359AbWK2L0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966359AbWK2L0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966591AbWK2L0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:26:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:14369 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S966359AbWK2L0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:26:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XegVm2A8XXl0aWH2mRwX+1brew87sS9B/IZqXwjHpv9MOIrC0h9vnm4vpCLJIW+BX0w6w2/OSnATFNk2JnkuT9gP4d2P3RxYmQHXvhCd1aCM79RalBXjjGElbqaLaRZ03yzUnp2uHoV7Yh9gvpV5ATzyBTk8sGcueUaAGZeebxw=
Message-ID: <456D6E59.1020507@gmail.com>
Date: Wed, 29 Nov 2006 09:26:17 -0200
From: Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 tsc clocksource + ntp = excessive drift; acpi_pm does
 fine.
References: <456CCA54.6090504@gmail.com> <1164762181.5521.49.camel@localhost.localdomain>
In-Reply-To: <1164762181.5521.49.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cut]

>
>Also does booting w/ "noapic" change the behavior?
>  
>

No, it didn't. It behaves exactly as before.

- Alexandre

