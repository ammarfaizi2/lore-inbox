Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVASTKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVASTKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVASTKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:10:33 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21891 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261854AbVASTKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:10:04 -0500
Message-ID: <41EEB146.6040004@tmr.com>
Date: Wed, 19 Jan 2005 14:13:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alban Browaeys <prahal@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
References: <41ED8D5F.5030409@tmr.com> <loom.20050119T013904-64@post.gmane.org>
In-Reply-To: <loom.20050119T013904-64@post.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alban Browaeys wrote:
> Bill Davidsen <davidsen <at> tmr.com> writes:
> 
> 
>>With no disrespect, I don't believe you have ever been a full-time 
>>employee system administrator for any commercial or government 
>>organization, and I don't believe you have any experience trying to do 
>>security when change must be reviewed by technically naive management to 
>>justify cost, time, and policy implications. The people on the list who 
>>disagree may view the security information issue in a very different 
>>context.
> 
> 
> Basically you are saying that if i disagree, my view is irrelevant. What do you
> expect with this kind of start. 

What I am saying is what I said, no reinterpretation needed. Linus has 
not had the experience of being an administrator working where policies 
and resources are controlled by someone else. I think experience is 
valuable.
> 
> 
>>Linus Torvalds wrote:

>>Unfortunately reality doesn't agree with you. Many organizations have no 
>>other effective way to convince management of the need for a fix except 
>>newspaper articles and magazine articles. A sometimes that has to get to 
>>the horror story stage before action is possible.
> 
> 
> 
> All those to lines to say one thing . Managing security requires social skills.

And people who haven't been there would not appreciate the reality if I 
said it in one line.
> 
>  
> 
>>>And let's not kid ourselves: the security firms may have resources that 
>>>they put into it, but the worst-case schenario is actual criminal intent. 
>>>People who really have resources to study security problems, and who have 
>>>_no_ advantage of using vendor-sec at all. And in that case, vendor-sec is 
>>>_REALLY_ a huge mistake. 
>>
>>I think you are still missing the point, I don't care if a security firm 
>>reads mailing lists or tea leaves, does research or just knows where to 
>>find it, they are paid to do it and if they do it well and report the 
>>problems which apply to me and the source of the fixes they keep me from 
>>missing something and at the same time save me time. Even reading only 
>>good mailing lists and newsgroups it takes a lot of time to keep 
>>current, and you see a lot of stuff you don't need.
>>
> 
> 
> Does this resume to :

Again it means what it says, security services are cost effective. They 
control the resources used in providing security, because in some 
companies there simply aren't the human resources available to do a good 
job.

> I want my company to be in control. And nobody else please, because i do not
> trust them.
> Who would you want in this security board ? No hackers i believe they have no
> incentive to shut the *** up, they do not care about money or their buisness or
> who knows why.
> 
> So you want :
> a/ everyboddy is wrong, we cannot understand,
> b/ crackers "are too lazy in many cases to read the high-level hacker boards"
> c/ "How can i have fix without ever having a hole ?".
> Close your eyes and believe, that s the only way to achieved absolute safety.
> I am not kidding, billions of people does this, it seems efficient (only few
> dies by accident).
> d/ the world is mad , nobody cares about security except who we are in charge
> (and have no power in the politics).
> e/ i don t care who does the job but i want my god damn system to have no holes.

I don't know how you got to this list from what I posted...

> Sorry for this rude analysis . I assume you want :
> 1/ a way to be alerted of the security hole of your application stack , and
> those only.
> 2/ fix before the script kiddies.

And that is a reasonable summary of the goals.
> 
> For one the fix is quite easy, it is a matter of getting security alerts in an
> easy way (maybe newsletter are getting old, what about a web as amazon does for
> stuff) and a filter on your application stack.

I actually like newsletter and Email alerts, they can be set to generate 
interrupts at the level appropriate, from "you have mail" to pager 
alerts, as desired.
> 
> For two, nobody can help. Script kiddies does not even read tech lists. They do
> not make the scripts. Those who made them usually don't just read ML, they read
> source, even binaries.
> And those who make a living of cracking usually do not tell anybody. No CERT
> alert. The only hope is easy to read code, audit.

I don't regard any solution less that perfect as "nobody can help." 
Timely fixes significantly reduce the exposure, the world isn't perfect. 
As my wife says, "Life's a bitch. Then you die."

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
