Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVAEACu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVAEACu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVAEACt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:02:49 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:25232 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262162AbVAEAAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:00:30 -0500
Message-ID: <41DB2E20.90309@tmr.com>
Date: Tue, 04 Jan 2005 19:00:32 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Thomas Graf <tgraf@suug.ch>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <200501041534.j04FY9g7008583@laptop11.inf.utfsm.cl><200501041534.j04FY9g7008583@laptop11.inf.utfsm.cl> <20050104211910.GB7280@thunk.org>
In-Reply-To: <20050104211910.GB7280@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Tue, Jan 04, 2005 at 12:34:09PM -0300, Horst von Brand wrote:
> 
>>Thomas Graf <tgraf@suug.ch> said:
>>
>>>* Theodore Ts'o <20050104002452.GA8045@thunk.org> 2005-01-03 19:24
>>>
>>>>I was thinking more about every week or two (ok, two releases in a day
>>>>like we used to do in the 2.3 days was probably too freequent :-), but
>>>>sure, even going to a once-a-month release cycle would be better than
>>>>the current 3 months between 2.6.x releases.
>>
>>>It definitely satifies many of the impatients but it doesn't solve the
>>>stability problem. Many bugs do not show up on developer machines until
>>>just right after the release (as you pointed out already). rc releases
>>>don't work out as expected due to various reasons, i think one of them
>>>is that rc releases don't get announced on the newstickers, extra work
>>>is required to patch the kernel etc. What about doing a test release
>>>just before releasing the final version. I'm not talking about yet
>>>another 2 weeks period but rather just 2-3 days and at most 2 bk
>>>releases in between.
>>
>>And most users will just wait the extra 2 or 3 days before timidly dipping
>>in. Doesn't work.
> 
> 
> Some will start testing right away, others will wait 2 or 3 days
> first.  And that's fine.  Not all 2.6.x kernels will be good; but if
> we do releases every 1 or 2 weeks, some of them *will* be good.  The
> problem with the -rc releases is that we try to predict in advance
> which releases in advance will be stable, and we don't seem to be able
> to do a good job of that.  If we do a release every week, my guess is
> that at least 1 in 3 releases will turn out to be stable enough for
> most purposes.  But we won't know until after 2 or 3 days which
> releases will be the good ones.

I'm not an optimist; I assumed -rc meant "only fixes" and was worth 
testing to get bugs identified. And that's what I would hope could 
happen again. If you think -fo (fixes only) is a better term I wouldn't 
argue.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
