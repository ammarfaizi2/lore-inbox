Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130437AbRCCKKc>; Sat, 3 Mar 2001 05:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRCCKKM>; Sat, 3 Mar 2001 05:10:12 -0500
Received: from [62.231.2.151] ([62.231.2.151]:30992 "EHLO mail.ixcelerator.com")
	by vger.kernel.org with ESMTP id <S130437AbRCCKKK>;
	Sat, 3 Mar 2001 05:10:10 -0500
Date: Sat, 3 Mar 2001 13:09:04 +0300
Message-Id: <200103031009.f23A94Y26374@morgoth.ixcelerator.com>
From: green@ixcelerator.com
To: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 TCP window shrinking
X-Newsgroups: linux.kernel
In-Reply-To: <15008.6084.410042.53699@pizda.ninka.net>
User-Agent: tin/1.4.2-20000205 ("Possession") (UNIX) (Linux/2.4.2 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

In article <15008.6084.410042.53699@pizda.ninka.net> you wrote:
>  > TCP: peer xxx.xxx.1.11:41154/80 shrinks window 2442047470:1072:2442050944.
>  > Bad, what else can I say?
> We need desperately to know exactly what OS the xxx.xxx.1.14 machine
> is running.  Because you've commented out the first two octets, I
> cannot check this myself using nmap.
Hope that helps:
TCP: peer 192.115.216.67:4965/80 shrinks window 1189646194:1024:1189647309. Bad, what else can I say?
TCP: peer 192.115.216.66:48184/80 shrinks window 1233448155:1024:1233449294. Bad, what else can I say?
TCP: peer 192.115.216.67:4388/80 shrinks window 2353869396:1024:2353870499. Bad, what else can I say?
TCP: peer 212.100.133.70:2228/80 shrinks window 3072654250:512:3072655786. Bad, what else can I say?
TCP: peer 212.100.133.70:2228/80 shrinks window 3072657834:512:3072659370. Bad, what else can I say?
TCP: peer 212.100.133.70:2228/80 shrinks window 3072658346:0:3072659370. Bad, what else can I say?
TCP: peer 212.100.133.70:2228/80 shrinks window 3072658346:512:3072659370. Bad, what else can I say?
TCP: peer 212.100.133.70:2243/80 shrinks window 3126499925:512:3126501461. Bad, what else can I say?
TCP: peer 212.100.133.70:2243/80 shrinks window 3126500437:0:3126501461. Bad, what else can I say?
TCP: peer 212.100.133.70:2243/80 shrinks window 3126500437:512:3126501461. Bad, what else can I say?
TCP: peer 212.100.133.70:2243/80 shrinks window 3126503509:512:3126504533. Bad, what else can I say?
TCP: peer 212.100.133.70:2243/80 shrinks window 3126505045:512:3126505591. Bad, what else can I say?
TCP: peer 212.100.133.70:2243/80 shrinks window 3126505557:0:3126505591. Bad, what else can I say?
TCP: peer 168.97.99.66:1759/80 shrinks window 3811940743:1460:3811943663. Bad, what else can I say?
TCP: peer 192.115.216.67:1117/80 shrinks window 821320812:1024:821321847. Bad, what else can I say?
TCP: peer 194.85.201.96:1231/80 shrinks window 1491890080:3072:1491893832. Bad, what else can I say?
TCP: peer 194.85.201.96:1231/80 shrinks window 1491894368:3072:1491898120. Bad, what else can I say?
TCP: peer 194.85.202.100:3072/80 shrinks window 1517168757:1536:1517171677. Bad, what else can I say?
TCP: peer 147.226.5.4:18052/80 shrinks window 3091312994:2864:3091316312. Bad, what else can I say?
TCP: peer 208.152.106.86:1496/80 shrinks window 1047754391:1072:1047755999. Bad, what else can I say?
TCP: peer 193.235.226.2:57881/80 shrinks window 3860496316:2920:3860503895. Bad, what else can I say?
TCP: peer 199.103.141.186:4260/80 shrinks window 1544210503:4380:1544216343. Bad, what else can I say?
TCP: peer 194.85.204.37:62553/80 shrinks window 1582101904:0:1582101905. Bad, what else can I say?
TCP: peer 168.97.99.66:4077/80 shrinks window 2705297980:1460:2705300900. Bad, what else can I say?
TCP: peer 194.85.201.4:1483/80 shrinks window 3797292442:0:3797293210. Bad, what else can I say?
TCP: peer 194.85.201.4:1483/80 shrinks window 3797293978:0:3797294746. Bad, what else can I say?
TCP: peer 194.85.201.4:1483/80 shrinks window 3797295514:0:3797296282. Bad, what else can I say?
TCP: peer 194.85.201.4:1483/80 shrinks window 3797297050:0:3797297818. Bad, what else can I say?
TCP: peer 194.85.201.4:1483/80 shrinks window 3797298586:0:3797299354. Bad, what else can I say?
TCP: peer 168.97.99.66:2466/80 shrinks window 879491421:1460:879494341. Bad, what else can I say?
TCP: peer 140.140.59.101:2839/80 shrinks window 2408864318:1460:2408867238. Bad, what else can I say?
TCP: peer 209.47.130.2:2166/80 shrinks window 2408449733:1072:2408450854. Bad, what else can I say?
TCP: peer 194.85.201.4:1988/80 shrinks window 2620331555:0:2620332323. Bad, what else can I say?
TCP: peer 194.85.201.4:1988/80 shrinks window 2620333091:0:2620333859. Bad, what else can I say?
TCP: peer 194.85.201.4:1988/80 shrinks window 2620334627:0:2620335395. Bad, what else can I say?
TCP: peer 213.189.85.106:1875/80 shrinks window 3265282896:2920:3265290197. Bad, what else can I say?
TCP: peer 204.100.181.6:3081/80 shrinks window 3215499301:2920:3215503041. Bad, what else can I say?
TCP: peer 140.228.46.0:1218/80 shrinks window 3743350500:1072:3743351700. Bad, what else can I say?
TCP: peer 212.248.7.86:2382/80 shrinks window 3235025401:512:3235026937. Bad, what else can I say?
TCP: peer 195.129.34.34:51780/80 shrinks window 1301988509:2920:1301992794. Bad, what else can I say?
TCP: peer 195.75.131.34:34715/80 shrinks window 4249402792:1024:4249404950. Bad, what else can I say?
TCP: peer 195.75.131.34:34715/80 shrinks window 4249403304:1024:4249404950. Bad, what else can I say?
TCP: peer 195.75.131.34:34715/80 shrinks window 4249403816:1024:4249404950. Bad, what else can I say?
TCP: peer 193.235.226.2:19253/80 shrinks window 180598643:2920:180603811. Bad, what else can I say?  
TCP: peer 194.85.202.123:1713/80 shrinks window 2313955067:0:2313955161. Bad, what else can I say?
TCP: peer 193.235.226.2:50139/80 shrinks window 2386493452:2920:2386498376. Bad, what else can I say?
TCP: peer 193.235.226.2:54973/80 shrinks window 2445719253:2920:2445722177. Bad, what else can I say?
TCP: peer 193.235.226.2:21774/80 shrinks window 2667266701:2920:2667274191. Bad, what else can I say?
TCP: peer 194.85.201.67:4945/80 shrinks window 4057913997:0:4057914765. Bad, what else can I say?
TCP: peer 194.85.201.67:4945/80 shrinks window 4057915533:0:4057916301. Bad, what else can I say?
TCP: peer 194.85.201.67:4945/80 shrinks window 4057919373:0:4057920141. Bad, what else can I say?
TCP: peer 194.85.201.67:4945/80 shrinks window 4057920909:0:4057921677. Bad, what else can I say?
TCP: peer 194.85.201.67:4945/80 shrinks window 4057922445:0:4057923213. Bad, what else can I say?
TCP: peer 194.85.201.67:1050/80 shrinks window 4242245882:0:4242246650. Bad, what else can I say?
TCP: peer 194.85.201.67:1050/80 shrinks window 4242248186:0:4242248954. Bad, what else can I say?
TCP: peer 194.85.201.67:1050/80 shrinks window 4242252794:0:4242253562. Bad, what else can I say?
TCP: peer 194.85.201.67:1050/80 shrinks window 4242254330:0:4242255098. Bad, what else can I say?
TCP: peer 194.85.201.67:1050/80 shrinks window 4242257402:0:4242258063. Bad, what else can I say?
TCP: peer 194.85.201.4:1411/80 shrinks window 2629285337:0:2629286105. Bad, what else can I say?
TCP: peer 194.85.201.4:1411/80 shrinks window 2629286873:0:2629287641. Bad, what else can I say?
TCP: peer 194.85.201.4:1411/80 shrinks window 2629292249:0:2629293017. Bad, what else can I say?
TCP: peer 194.85.201.4:1519/80 shrinks window 3119239302:0:3119240070. Bad, what else can I say?
TCP: peer 171.31.0.10:7866/80 shrinks window 3204908317:1460:3204911007. Bad, what else can I say?
TCP: peer 194.85.201.4:1555/80 shrinks window 3267511310:0:3267512078. Bad, what else can I say?
TCP: peer 194.85.201.4:1555/80 shrinks window 3267512846:0:3267513614. Bad, what else can I say?
TCP: peer 194.85.201.4:1555/80 shrinks window 3267514382:0:3267515088. Bad, what else can I say?
TCP: peer 163.162.71.174:43725/80 shrinks window 3590587728:2920:3590592038. Bad, what else can I say?
TCP: peer 213.181.149.4:17078/80 shrinks window 3631534953:6210:3631541193. Bad, what else can I say?
TCP: peer 168.97.99.66:8696/80 shrinks window 3752919838:à007:3752922758. Bad, what else can I say?
TCP: peer 194.85.201.67:3312/80 shrinks window 3849647421:0:3849648189. Bad, what else can I say?
TCP: peer 194.85.201.67:3312/80 shrinks window 3849648957:0:3849649725. Bad, what else can I say?
TCP: peer 194.85.201.67:3312/80 shrinks window 3849650493:0:3849651261. Bad, what else can I say?

Bye,
    Oleg
