Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281355AbRKVTOe>; Thu, 22 Nov 2001 14:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRKVTOZ>; Thu, 22 Nov 2001 14:14:25 -0500
Received: from AGrenoble-101-1-5-109.abo.wanadoo.fr ([80.11.136.109]:44421
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281355AbRKVTOS> convert rfc822-to-8bit; Thu, 22 Nov 2001 14:14:18 -0500
Message-ID: <3BFD4F57.8030408@wanadoo.fr>
Date: Thu, 22 Nov 2001 20:17:43 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: James A Sutherland <jas88@cam.ac.uk>
Cc: Rik van Riel <riel@conectiva.com.br>, war <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <Pine.LNX.4.33L.0111221456020.1491-100000@duckman.distro.conectiva> <3BFD4A42.8090002@wanadoo.fr> <E166z3N-00020W-00@mauve.csi.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James A Sutherland wrote:

>>Obviously the problem is very much lessened, in my case, when
>>i put the swap partition on the *other* drive than the root fs.
>>Both are ATA100 (40GB 60GXPs), and the system is more responsive
>>with swap on hdc while / in on hda, than both on hda.
>>
> 
> Hmm... if you've experimented with this, how does this setup compare to a 
> striped RAID of hda+hdc used for root and swap? (i.e. is the speedup down to 
> splitting accesses between two spindles?)


I haven't, but it's a good idea, I may give it a try, but not very soon.

François

