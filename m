Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319386AbSIFXPP>; Fri, 6 Sep 2002 19:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319418AbSIFXPO>; Fri, 6 Sep 2002 19:15:14 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:39952 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S319386AbSIFXPN>;
	Fri, 6 Sep 2002 19:15:13 -0400
From: <Hell.Surfers@cwctv.net>
To: reiser@namesys.com, aaronl@vitelus.com, Nikita@Namesys.COM, sct@redhat.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Date: Sat, 7 Sep 2002 00:19:00 +0100
Subject: RE:Re: ext3 throughput woes on certain (possibly heavily fragmented)
 files
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1031354340758"
Message-ID: <0dafd0118230692DTVMAIL9@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1031354340758
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Perhaps you could use a fat partition, you can defragment those, or ntfs [mwaaaahahaha].



On 	Sat, 07 Sep 2002 02:05:12 +0400 	Hans Reiser <reiser@namesys.com> wrote:

--1031354340758
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Fri, 6 Sep 2002 23:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319405AbSIFWAj>; Fri, 6 Sep 2002 18:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319406AbSIFWAj>; Fri, 6 Sep 2002 18:00:39 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:30725 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319405AbSIFWAi>; Fri, 6 Sep 2002 18:00:38 -0400
Received: (qmail 19618 invoked from network); 6 Sep 2002 22:05:12 -0000
Received: from reload.namesys.com (HELO namesys.com) (212.16.7.75)
  by thebsh.namesys.com with SMTP; 6 Sep 2002 22:05:12 -0000
Message-ID: <3D792698.4010401@namesys.com>
Date: Sat, 07 Sep 2002 02:05:12 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Nikita Danilov <Nikita@Namesys.COM>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented)
 files
References: <20020903092419.GA5643@vitelus.com> <20020906170614.A7946@redhat.com> <15736.57972.202889.872554@laputa.namesys.com> <3D78E44E.5020107@namesys.com> <20020906210214.GA25666@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

Aaron Lehmann wrote:

>On Fri, Sep 06, 2002 at 09:22:22PM +0400, Hans Reiser wrote:
>  
>
>>I think I prefer that we implement a repacker for reiser4 though, as 
>>that, combined with delayed allocation, will be a balanced and thorough 
>>solution.
>>    
>>
>
>How does current ReiserFS fare against extreme fragmentation? What
>about XFS? Without trying to risk a flamewar, what Linux filesystems
>are the most preventive of fragmentation?
>
>The filesystem could make a huge difference on a machine like a mail
>server...
>
>
>  
>
Sometimes it is best to confess that one does not have the expertise 
appropriate for answering a question. Someone on our mailing list 
studied it carefully though. Perhaps they can comment.

Hans

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1031354340758--


