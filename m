Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274468AbRJNGV4>; Sun, 14 Oct 2001 02:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRJNGVq>; Sun, 14 Oct 2001 02:21:46 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:17681 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S274468AbRJNGVb>;
	Sun, 14 Oct 2001 02:21:31 -0400
Message-ID: <3BC92F07.7030801@thock.com>
Date: Sun, 14 Oct 2001 00:21:59 -0600
From: Dylan Griffiths <dylang+kernel@thock.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010926
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: HPT 370 / RAID 5 possible corruption issue.]
In-Reply-To: <3BC381DE.4090300@thock.com> <20011012012453.C6330@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard wrote:

> I can't say what the current status is.   But some time ago some people I know
> got burnt with silent corruption from using HPT cards with RAID5 and RAID0, the
> cards were replaced with Promise cards, and the problem went away (as it should
> - I've been running a lot of RAID on Promise cards and never saw the problem).


I've got a spare Promise card now that I will test and keep posted of the 
results.

 
> As long as there are Promise cards to get, I'm not going anywhere near HPT.
> 
> Maybe there's a fix somewhere, maybe there's a magic BIOS setting or upgrade,
> maybe something else can make it work, I don't know.  Promise cards are cheap
> so I don't care.
> 
> Sorry for not being able to give you "good" information, but at least now you
> got "some" information.   Hope it helps, for what it's worth.
> 

I wonder, if the HPT card support is so bad, or the hardware itself is so 
squirelly, why it's not marked as UNSTABLE or has a note about the HW 
being evil.

-- 
     www.kuro5hin.org -- technology and culture, from the trenches.
                          -=-=-=-=-=-
Those that give up liberty to obtain safety deserve neither.
  -- Benjamin Franklin
   http://www.zdnet.com/zdnn/stories/news/0,4586,2812463,00.html
   http://slashdot.org/article.pl?sid=01/09/16/1647231
                          -=-=-=-=-=-

