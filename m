Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbTFSLSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbTFSLSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:18:48 -0400
Received: from mx1.aruba.it ([62.149.128.130]:58002 "HELO mx1.aruba.it")
	by vger.kernel.org with SMTP id S265769AbTFSLSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:18:45 -0400
Message-ID: <3EF19F59.3060303@despammed.com>
Date: Thu, 19 Jun 2003 13:32:41 +0200
From: Dialtone <dialtone@despammed.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ornati <javaman@katamail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [despammed] Re: [2.4.21-ck1] Problem with nforce2 and X
References: <3EF0A1A3.3020606@despammed.com> <S265707AbTFSGcL/20030619063211Z+6415@vger.kernel.org>
In-Reply-To: <S265707AbTFSGcL/20030619063211Z+6415@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Rating: mx1.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:

>Have you read "NVIDIA Accelerated Linux Driver Set README & Installation 
>Guide"?
>
>Try to add this option to the Section "Device" of your XF86Config-4 file:
>Option "NvAgp" "0"
>  
>

Oh well thanks. I already read all the Installation Guide some times but
I didn't find out that this was the solution...

Thx a lot.

-- 
try: troll.uses(Brain)
except TypeError, data: 
   troll.plonk()
Linux User #310274, Debian Sid Proud User


