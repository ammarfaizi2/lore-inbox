Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSDISSD>; Tue, 9 Apr 2002 14:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSDISSC>; Tue, 9 Apr 2002 14:18:02 -0400
Received: from otter.mbay.net ([206.55.237.2]:26628 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S292130AbSDISSB> convert rfc822-to-8bit;
	Tue, 9 Apr 2002 14:18:01 -0400
From: John Alvord <jalvo@mbay.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com
Subject: Re: Event logging vs enhancing printk
Date: Tue, 09 Apr 2002 11:17:33 -0700
Message-ID: <rhb6buc00e9hulk8l6q02lqvhd391n5gup@4ax.com>
In-Reply-To: <200204090821.g398LjX01722@Port.imtp.ilyichevsk.odessa.ua> <1979709341.1018338151@[10.10.2.3]>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Apr 2002 07:42:32 -0700, "Martin J. Bligh"
<Martin.Bligh@us.ibm.com> wrote:

>> As I understand, Linus accepts new features only if they are improving
>> kernel  in some vital area significantly (for example, Ingo's new
>> scheduler).
>
>I think that's more true of 2.4 than 2.5, but a change should indeed 
>make some improvement to be accepted. What seems to be more vital
>is that the cost:benefit ratio is advantageous ... much of the
>discussions that Larry and I were having were oriented to keeping
>the cost very low indeed ... if you didn't turn on event logging,
>the cost would be pretty much 0 (just those macro unwraps).
>
What I have observed is that Linus tends to accept some major changes
that have achieved a certain consensus. ReiserFS is a good example. It
was in wide use and was being shipped by SUSE... not universal but
there was significant usage. Other good ideas with no significant
usage languish unless it is something interesting to Linus himself.

john
