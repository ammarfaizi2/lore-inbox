Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281994AbRKUXXv>; Wed, 21 Nov 2001 18:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281995AbRKUXXc>; Wed, 21 Nov 2001 18:23:32 -0500
Received: from AGrenoble-101-1-5-109.abo.wanadoo.fr ([80.11.136.109]:39562
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281994AbRKUXXX> convert rfc822-to-8bit; Wed, 21 Nov 2001 18:23:23 -0500
Message-ID: <3BFC382F.60405@wanadoo.fr>
Date: Thu, 22 Nov 2001 00:26:39 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 not supported by kernel !!!!!
In-Reply-To: <EXCH01SMTP01eaCYPct00001063@smtp.netcabo.pt>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Maria Godinho de Matos wrote:


> fs ext3 not supported by kernel!
> 
> This was for what i  think something i misschoose in the make config step am 
> i right??'


yes and no... basically vanilla 2.4.14 doesn't support ext3,
although you can patch it to get ext3.

either you want to try 2.4.15pre8 and you have to patch your 2.4.14
with
http://www.kernel.org/pub/linux/kernel/testing/patch-2.4.15-pre8.gz
or you can patch 2.4.14 with the ext3 patch at :
http://beta.redhat.com/index.cgi?action=ext3
or you can wait for 2.4.15


> If so can one of u tell me which menu contains the ext3 support for the 
> kernel compilation.


Filesystems

François

